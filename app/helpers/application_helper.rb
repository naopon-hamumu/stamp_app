module ApplicationHelper
  def bootstrap_class_for_flash(type)
    case type
    when 'notice' then 'info'
    when 'success' then 'success'
    when 'error' then 'danger'
    when 'alert' then 'warning'
    else type.to_s
    end
  end

  def page_title(page_title = '')
    base_title = 'Stamp Bon Voyage'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def default_meta_tags
    { 
      site: 'Stamp Bon Voyage',
      title: 'スタンプラリー作成・参加サービス',
      reverse: true,
      charset: 'utf-8',
      description: '自由にスタンプラリーを作れて遊べるのだ🐹',
      keywords: 'スタンプラリー, スタンプ, ハムスター',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.jpg'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@',
        image: image_url('ogp.jpg')
      }
    }
  end
end
