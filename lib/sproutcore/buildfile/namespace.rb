module SC
  
  # The NameSpace class will lookup task names in the the scope
  # defined by a +namespace+ command.  Borrowed from Rake 0.8.3
  #
  class NameSpace

    # Create a namespace lookup object using the given task manager
    # and the list of scopes.
    def initialize(task_manager, scope_list)
      @task_manager = task_manager
      @scope = scope_list.dup
    end

    # Lookup a task named +name+ in the namespace.
    def [](name)
      @task_manager.lookup(name, @scope)
    end

    # Return the list of tasks defined in this namespace.
    def tasks
      @task_manager.tasks
    end
  end # NameSpace
  
end