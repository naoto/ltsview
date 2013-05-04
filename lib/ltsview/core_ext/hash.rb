class Hash
  def to_ltsv
    LTSV.dump(self)
  end
end
