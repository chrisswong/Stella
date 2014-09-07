class Build < ActiveRecord::Base
	mount_uploader :buildFilePath, BuildUploader
end
