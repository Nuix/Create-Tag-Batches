# Menu Title: Create Tag Batches
# Needs Case: true
# Needs Selected Items: true
# v1.3

require_relative "Nx.jar"
java_import "com.nuix.nx.NuixConnection"
java_import "com.nuix.nx.LookAndFeelHelper"
java_import "com.nuix.nx.dialogs.ChoiceDialog"
java_import "com.nuix.nx.dialogs.TabbedCustomDialog"
java_import "com.nuix.nx.dialogs.CommonDialogs"
java_import "com.nuix.nx.dialogs.ProgressDialog"
java_import "com.nuix.nx.digest.DigestHelper"

LookAndFeelHelper.setWindowsIfMetal
NuixConnection.setUtilities($utilities)
NuixConnection.setCurrentNuixVersion(NUIX_VERSION)

load File.join(File.dirname(__FILE__),"TagBatcher.rb")

items = $current_selected_items

if items.size < 1
	CommonDialogs.showInformation("Please select some items before running this script.")
	exit 1
end

dialog = TabbedCustomDialog.new("Create Tag Batches")
dialog.enableStickySettings(File.join(File.dirname(__FILE__),"recent_settings.json"))

main_tab = dialog.addTab("main_tab","Main")
main_tab.appendHeader("Selected Items: #{items.size}")
main_tab.appendTextField("name_prefix","Tag Name Prefix","Batch|")
main_tab.appendRadioButton("use_batch_size","Use Batch Size","batching_method",true)
main_tab.appendTextField("batch_size","Batch Size (Top Level Items)","200")
main_tab.appendRadioButton("use_batch_count","Use Batch Count","batching_method",false)
main_tab.appendTextField("batch_count","Desired Batch Count","20")
main_tab.enabledOnlyWhenChecked("batch_count","use_batch_count")
main_tab.enabledOnlyWhenChecked("batch_size","use_batch_size")

dialog.validateBeforeClosing do |values|
	if values["use_batch_size"]
		begin
			batch_size = values["batch_size"].to_i
		rescue
			CommonDialogs.showError("Please provide a valid batch size value.")
			next false
		end
	end

	if values["use_batch_count"]
		begin
			batch_count = values["batch_count"].to_i
		rescue
			CommonDialogs.showError("Please provide a valid batch count value.")
			next false
		end
	end

	next true
end

dialog.display
if dialog.getDialogResult == true
	values = dialog.toMap
	values["batch_size"] = values["batch_size"].to_i
	values["batch_count"] = values["batch_count"].to_i
	ProgressDialog.forBlock do |pd|
		pd.setTitle("Create Tag Batches")
		pd.setSubProgressVisible(false)
		pd.setAbortButtonVisible(false)
		batcher = TagBatcher.new
		pd.setMainProgress(0,items.size)
		batcher.on_progress_update do |current_value|
			pd.setMainProgress(current_value)
			pd.setMainStatus("#{current_value}/#{items.size}")
		end
		batcher.on_message do |message|
			pd.logMessage(message)
		end
		batcher.batch_jobs(items,values)

		pd.setMainStatus("Completed")
	end
end