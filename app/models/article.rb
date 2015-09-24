class Article < ActiveRecord::Base
	has_many :comments
	has_many :taggings
	has_many :tags, through: :taggings
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	def tag_list
		tags.join(', ')
	end

	def tag_list=(tag_strings)
		tag_names=tag_strings.split(',').collect {|s| s.strip.downcase}.uniq
		new_found_tags=tag_names.collect {|name| Tag.find_or_create_by(name: name)}
		self.tags=new_found_tags
	end
end
	