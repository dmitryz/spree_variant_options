Spree::OptionValue.class_eval do

  has_attached_file :image,
    :styles        => { small: '40x30', mini: '32x32>', normal: '128x128>' },
    :default_style => SpreeVariantOptions::VariantConfig[:option_value_default_style],
    :url           => SpreeVariantOptions::VariantConfig[:option_value_url],
    :path          => SpreeVariantOptions::VariantConfig[:option_value_path]

	validates_attachment_content_type :image, :content_type => [/\Aimage/, /\Aaudio/]

	validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /mp3\Z/]


  def has_image?
    image_file_name && !image_file_name.empty?
  end

  default_scope { order("#{quoted_table_name}.position") }
  scope :for_product, lambda { |product| select("DISTINCT #{table_name}.*").where("spree_option_values_variants.variant_id IN (?)", product.variant_ids).joins(:variants) }
end
