module Recommend
  RECENT_PARTICIPATE = 30
  DEFAULT_PAGE_ITEM_COUNT = 9

  def self.recommend_tag(current_user)
    recommends = current_user.participants
                             .order(updated_at: :desc)
                             .limit(RECENT_PARTICIPATE)

    array = Array.new
    recommends.each do |recommend|
      stamp_rally = StampRally.find_by(id: recommend.stamp_rally_id)
      tags = stamp_rally.tags.pluck(:name)
      array.push(tags)
    end

    return array.compact
                .flatten
                .group_by{ |e| e }
                .sort_by{ |_, v| -v.size }
                .map(&:first)[0..4]
                .sample
  end

  def self.recommend_stamp_rallies(user_id, recommend_tag, params)
    tag = Tag.find_by(name: recommend_tag)
    
    stamp_rallies = if tag
      tag.stamp_rallies.public_open.where
         .not(user_id: user_id)
         .order(updated_at: :desc)
         .limit(DEFAULT_PAGE_ITEM_COUNT)
    end
  end
end
