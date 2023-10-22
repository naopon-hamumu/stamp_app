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

  def self.recommend_stamp_rallies(user, recommend_tag, params) # user_idをuserに変更
    tag = Tag.find_by(name: recommend_tag)

    if tag
      participated_stamp_rally_ids = user.participate_stamp_rallies.ids # 参加しているスタンプラリーのIDを取得
      tag.stamp_rallies
         .public_open
         .where.not(id: participated_stamp_rally_ids) # 参加しているスタンプラリーを除外
         .order(updated_at: :desc)
         .limit(DEFAULT_PAGE_ITEM_COUNT)
    else
      [] # タグが見つからない場合、空の配列を返します
    end
  end
end
