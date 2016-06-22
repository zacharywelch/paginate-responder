module PaginateResponder
  module VERSION
    MAJOR = 1
    MINOR = 4
    PATCH = 3
    STAGE = :beta0

    def self.to_s
      [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join '.'
    end
  end
end
