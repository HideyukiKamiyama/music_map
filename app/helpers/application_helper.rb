module ApplicationHelper
  def flash_message_color(type)
    case type.to_sym
    when :notice then "bg-green-200 text-green-600"
    when :alert  then "bg-red-200 text-red-600"
    else "bg-gray-200 text-gray-600"
    end
  end

  def page_title(title = "")
    base_title = "MelodyMap"
    title.empty? ? base_title : "#{title} | #{base_title}"
  end

  def default_meta_tags
    {
      site: "MelodyMap",
      title: "街と音楽を繋げるお出かけアプリ♪",
      reverse: false,
      charset: "utf-8",
      description: "音楽に関する聖地を登録、検索することで聖地巡礼を楽しむことができるアプリです",
      keywords: "",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_url("ogp.png"),
        local: "ja-JP"
      },
      x: {
        card: "summary_large_image",
        site: "@RUNTEQ46B151748",
        image: image_url("ogp.png")
      }
    }
  end
end
