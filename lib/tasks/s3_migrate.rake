namespace :s3 do
  desc "Migrate images to S3"
  task migrate: :environment do
    StampRally.all.each do |instance|
      if instance.image.file.exists?
        instance.image.recreate_versions!
        instance.save!
      end
    end

    Stamp.all.each do |instance|
      if instance.sticker.file.exists?
        instance.sticker.recreate_versions!
        instance.save!
      end
    end
  end
end
