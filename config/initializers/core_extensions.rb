class Object
  def to_yesno
    self ? "Yes" : "No"
  end
  alias to_noyes to_yesno
end

