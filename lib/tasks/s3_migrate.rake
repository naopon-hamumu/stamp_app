namespace :s3 do
  desc "Migrate images to S3"
  task migrate: :environment do
    ModelName.all.each do |instance|
      if instance.image.file.exists?
        instance.image.recreate_versions!
        instance.save!
      end
    end
  end
end
