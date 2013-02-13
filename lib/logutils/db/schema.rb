
module LogDB

class CreateDB   ## fix/todo: change to ActiveRecord::Migration why? why not?

def self.up

  ActiveRecord::Schema.define do

create_table :logs do |t|
  t.string  :msg,    :null => false
  t.string  :kind      # e.g. fatal, error, warn, info, debug
  t.string  :app
  t.string  :tag       # e.g. class name w/ namespace e.g. SportDB.Reader etc.
  t.timestamps
end

  end # block Schema.define

end # method up

end # class CreateDB

end # module LogDB
