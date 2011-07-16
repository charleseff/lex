class Administrator < User
  
  def to_label
    "#{email}"
  end

end
  