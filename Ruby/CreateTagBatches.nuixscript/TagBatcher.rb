
# Accepts a settings hash with the following
# name_prefix - Job name batch, will be suffixed by 4 fill sequence number
# batch_size - Number of top level items per batch

class TagBatcher
	def on_progress_update(&block)
		@progress_block = block
	end

	def on_message(&block)
		@message_block = block
	end

	def fire_progress_update(current)
		if !@progress_block.nil?
			@progress_block.call(current)
		end
	end

	def fire_message(message)
		puts message
		if !@message_block.nil?
			@message_block.call(message)
		end
	end

	def batch_jobs(items,settings)
		iutil = $utilities.getItemUtility
		batch_number = 1
		current_top_count = 0
		current_batch_items = []
		calculated_batch_size = settings["batch_size"]
		if settings["use_batch_count"]
			puts "Calculating batch size for count #{settings["batch_count"]}"
			top_level_item_count = iutil.findTopLevelItems(items).size
			calculated_batch_size = (top_level_item_count.to_f / settings["batch_count"]).ceil
		end
		puts "Calculated Batch Size: #{calculated_batch_size}"
		items.each_with_index do |item,item_index|
			fire_progress_update(item_index+1)
			if item.isTopLevel && current_top_count >= calculated_batch_size
				apply_batch_tag(current_batch_items,settings,batch_number)
				current_top_count = 0
				current_batch_items = []
				batch_number += 1
			end

			current_batch_items << item
			if item.isTopLevel
				current_top_count += 1
			end
		end

		if current_batch_items.size > 0
			apply_batch_tag(current_batch_items,settings,batch_number)
		end
	end

	def apply_batch_tag(items,settings,batch_number)
		name = settings["name_prefix"] + batch_number.to_s.rjust(4,"0")
		fire_message "Applying Tag '#{name}' to #{items.size} items"
		annotater = $utilities.getBulkAnnotater
		annotater.addTag(name,items)
	end
end