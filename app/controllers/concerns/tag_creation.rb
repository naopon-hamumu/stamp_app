module TagCreation
  extend ActiveSupport::Concern

  private

  def process_tags(stamp_rally)
    tag_names = params[:stamp_rally][:tag_names]
    if tag_names.present?
      tags = tag_names.split(',').map(&:strip).uniq
      create_or_update_stamp_rally_tags(stamp_rally, tags)
    end
  end

  def create_or_update_stamp_rally_tags(stamp_rally, tags)
    stamp_rally.tags.destroy_all
    tags.each do |tag|
      begin
        tag = Tag.find_or_create_by(name: tag)
        stamp_rally.tags << tag
      rescue => exception
        false
      end
    end
  end
end
