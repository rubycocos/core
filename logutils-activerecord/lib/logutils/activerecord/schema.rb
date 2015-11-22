
module LogDb

class CreateDb   ## fix/todo: change to ActiveRecord::Migration why? why not?

def self.up

  ActiveRecord::Schema.define do

create_table :logs do |t|
  t.string  :msg,    null: false
  t.string  :level,  null: false  # e.g. fatal, error, warn, info, debug
  t.string  :app
  t.string  :tag       # e.g. class name w/ namespace e.g. SportDB.Reader etc. # NB: change to name?
  t.integer :pid
  t.integer :tid,    limit: 8   # note: use 8 bytes e.g. bigint for mysql (default 4 bytes for mysql)
  t.string  :ts      # timestamp - change to datetime?
  # add filename, line, method ??
  t.timestamps
end

#####################################
# todo: add more fields ?? e.g.
#
# %m : The message to be logged
# %d : The ISO8601 Timestamp
# %L : The log level, e.g INFO, WARN
# %l : The log level (short), e.g. I, W
# %p : The PID of the process from where the log event occured
# %t : The Thread ID from where the log event occured
# %h : The hostname of the machine from where the log event occured
# %f : The filename from where the log event occured
# %n : The line number of the file from where the log event occured
# %F : The filename with path from where the log event occured
# %M : The method where the log event occured


  end # block Schema.define

end # method up

end # class CreateDb

end # module LogDb
