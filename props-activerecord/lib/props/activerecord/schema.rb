# encoding: utf-8

module ConfDb

class CreateDb

  def up
ActiveRecord::Schema.define do

create_table :props do |t|
  t.string :key,   null: false
  t.string :value, null: false

  # note: do NOT/can NOT use type - already used by ActiveRecord (for single-table-inheritance/STI)
  t.string :kind     # e.g. version|user|sys(tem)|db etc.

  t.timestamps
end

end # Schema.define
  end # method up

end  # class CreateDb

end  # module ConfDb
