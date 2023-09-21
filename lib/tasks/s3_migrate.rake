namespace :s3 do
  desc "Migrate images to S3"
  task migrate: :environment do
    StampRally.all.each do |instance|
      if instance.image && instance.image.file && instance.image.file.exists?
        puts "Processing StampRally ID: #{instance.id}"
        instance.image.recreate_versions!
        instance.save!
      end
    end

    Stamp.all.each do |instance|
      if instance.sticker && instance.sticker.file && instance.sticker.file.exists?
        puts "Processing Stamp ID: #{instance.id}"
        instance.sticker.recreate_versions!
        instance.save!
      end
    end
  end
end
