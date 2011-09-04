m1 = Machine.create(:name => 'm1')
m2 = Machine.create(:name => 'm2')
m3 = Machine.create(:name => 'm3')
m4 = Machine.create(:name => 'm4')
m5 = Machine.create(:name => 'm5')
m6 = Machine.create(:name => 'm6')
m7 = Machine.create(:name => 'm7')
m8 = Machine.create(:name => 'm8')
m9 = Machine.create(:name => 'm9')

p1 = Product.create(
  :name => 'p1',
  :operation_times  => [
    OperationTime.new(:machine => m1, :time => 428),
    OperationTime.new(:machine => m2, :time => 423),
    OperationTime.new(:machine => m3, :time => 459),
    OperationTime.new(:machine => m4, :time => 433),
    OperationTime.new(:machine => m5, :time => 467),
    OperationTime.new(:machine => m6, :time => 461),
    OperationTime.new(:machine => m7, :time => 464),
    OperationTime.new(:machine => m8, :time => 455),
    OperationTime.new(:machine => m9, :time => 418)
  ],
  :roadmaps => [
    Roadmap.new(:machines => [m1, m3, m4, m5, m7, m9]),
    Roadmap.new(:machines => [m2, m3, m5, m6, m8, m9])
  ]
)

p2 = Product.create(
  :name => 'p2',
  :operation_times  => [
    OperationTime.new(:machine => m1, :time => 439),
    OperationTime.new(:machine => m2, :time => 433),
    OperationTime.new(:machine => m3, :time => 487),
    OperationTime.new(:machine => m4, :time => 405),
    OperationTime.new(:machine => m5, :time => 447),
    OperationTime.new(:machine => m6, :time => 497),
    OperationTime.new(:machine => m7, :time => 495),
    OperationTime.new(:machine => m8, :time => 469),
    OperationTime.new(:machine => m9, :time => 439)
  ],
  :roadmaps => [
    Roadmap.new(:machines => [m1, m2, m3, m4, m5, m6, m7]),
    Roadmap.new(:machines => [m2, m3, m5, m7, m8, m9])
  ]
)

p3 = Product.create(
  :name => 'p3',
  :operation_times  => [
    OperationTime.new(:machine => m1, :time => 453),
    OperationTime.new(:machine => m2, :time => 474),
    OperationTime.new(:machine => m3, :time => 417),
    OperationTime.new(:machine => m4, :time => 447),
    OperationTime.new(:machine => m5, :time => 486),
    OperationTime.new(:machine => m6, :time => 496),
    OperationTime.new(:machine => m7, :time => 459),
    OperationTime.new(:machine => m8, :time => 489),
    OperationTime.new(:machine => m9, :time => 480)
  ],
  :roadmaps => [
    Roadmap.new(:machines => [m4, m5, m6, m7, m8]),
    Roadmap.new(:machines => [m2, m3, m7, m8, m9])
  ]
)

p4 = Product.create(
  :name => 'p4',
  :operation_times  => [
    OperationTime.new(:machine => m1, :time => 403),
    OperationTime.new(:machine => m2, :time => 436),
    OperationTime.new(:machine => m3, :time => 410),
    OperationTime.new(:machine => m4, :time => 410),
    OperationTime.new(:machine => m5, :time => 400),
    OperationTime.new(:machine => m6, :time => 468),
    OperationTime.new(:machine => m7, :time => 489),
    OperationTime.new(:machine => m8, :time => 439),
    OperationTime.new(:machine => m9, :time => 457)
  ],
  :roadmaps => [
    Roadmap.new(:machines => [m2, m3, m4, m6, m7]),
    Roadmap.new(:machines => [m1, m5, m6, m8, m9])
  ]
)

p5 = Product.create(
  :name => 'p5',
  :operation_times  => [
    OperationTime.new(:machine => m1, :time => 481),
    OperationTime.new(:machine => m2, :time => 440),
    OperationTime.new(:machine => m3, :time => 477),
    OperationTime.new(:machine => m4, :time => 442),
    OperationTime.new(:machine => m5, :time => 450),
    OperationTime.new(:machine => m6, :time => 468),
    OperationTime.new(:machine => m7, :time => 436),
    OperationTime.new(:machine => m8, :time => 486),
    OperationTime.new(:machine => m9, :time => 435)
  ],
  :roadmaps => [
    Roadmap.new(:machines => [m4, m5, m7, m8, m9]),
    Roadmap.new(:machines => [m1, m2, m3, m5, m6])
  ]
)

p6 = Product.create(
  :name => 'p6',
  :operation_times  => [
    OperationTime.new(:machine => m1, :time => 446),
    OperationTime.new(:machine => m2, :time => 495),
    OperationTime.new(:machine => m3, :time => 474),
    OperationTime.new(:machine => m4, :time => 448),
    OperationTime.new(:machine => m5, :time => 469),
    OperationTime.new(:machine => m6, :time => 408),
    OperationTime.new(:machine => m7, :time => 454),
    OperationTime.new(:machine => m8, :time => 424),
    OperationTime.new(:machine => m9, :time => 482)
  ],
  :roadmaps => [
    Roadmap.new(:machines => [m2, m4, m5, m6, m7, m8. m9]),
    Roadmap.new(:machines => [m1, m3, m6, m7, m8, m9])
  ]
)

p7 = Product.create(
  :name => 'p7',
  :operation_times  => [
    OperationTime.new(:machine => m1, :time => 414),
    OperationTime.new(:machine => m2, :time => 457),
    OperationTime.new(:machine => m3, :time => 452),
    OperationTime.new(:machine => m4, :time => 426),
    OperationTime.new(:machine => m5, :time => 493),
    OperationTime.new(:machine => m6, :time => 408),
    OperationTime.new(:machine => m7, :time => 457),
    OperationTime.new(:machine => m8, :time => 497),
    OperationTime.new(:machine => m9, :time => 445)
  ],
  :roadmaps => [
    Roadmap.new(:machines => [m1, m2, m4, m5, m6, m9]),
    Roadmap.new(:machines => [m1, m2, m3, m7, m8, m9])
  ]
)

p8 = Product.create(
  :name => 'p8',
  :operation_times  => [
    OperationTime.new(:machine => m1, :time => 491),
    OperationTime.new(:machine => m2, :time => 419),
    OperationTime.new(:machine => m3, :time => 435),
    OperationTime.new(:machine => m4, :time => 491),
    OperationTime.new(:machine => m5, :time => 495),
    OperationTime.new(:machine => m6, :time => 452),
    OperationTime.new(:machine => m7, :time => 477),
    OperationTime.new(:machine => m8, :time => 452),
    OperationTime.new(:machine => m9, :time => 408)
  ],
  :roadmaps => [
    Roadmap.new(:machines => [m4, m5, m6, m7, m8, m9]),
    Roadmap.new(:machines => [m3, m4, m5, m7, m8, m9])
  ]
)

p9 = Product.create(
  :name => 'p9',
  :operation_times  => [
    OperationTime.new(:machine => m1, :time => 458),
    OperationTime.new(:machine => m2, :time => 486),
    OperationTime.new(:machine => m3, :time => 416),
    OperationTime.new(:machine => m4, :time => 454),
    OperationTime.new(:machine => m5, :time => 452),
    OperationTime.new(:machine => m6, :time => 438),
    OperationTime.new(:machine => m7, :time => 484),
    OperationTime.new(:machine => m8, :time => 435),
    OperationTime.new(:machine => m9, :time => 416)
  ],
  :roadmaps => [
    Roadmap.new(:machines => [m3, m5, m6, m7, m8, m9]),
    Roadmap.new(:machines => [m2, m4, m6, m7, m8, m9])
  ]
)

