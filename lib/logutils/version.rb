
module LogUtils
  # NB: keep LogUtils namespace clean
  #  only include public API that gets included w/  include LogUtils in other modules
  # move all non public code/apis to LogKernel (including VERSION)
end

module LogKernel
  VERSION = '0.5.0'
end
