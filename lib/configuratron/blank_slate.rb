class BlankSlate
  class << self

    # Hide the method named +name+ in the BlankSlate class.  Don't
    # hide +instance_eval+ or any method beginning with "__".
    def hide(name)
      if instance_methods.include?(name) and name !~ /^(__|instance_eval|object_id)/
        @hidden_methods ||= {}
        @hidden_methods[name] = instance_method(name)
        undef_method name
      end
    end

    def find_hidden_method(name)
      @hidden_methods ||= {}
      @hidden_methods[name] || (superclass.find_hidden_method(name) if superclass.respond_to?(:find_hidden_method))
    end

    # Redefine a previously hidden method so that it may be called on a blank
    # slate object.
    def reveal(name)
      unbound_method = find_hidden_method(name)
      fail "Don't know how to reveal method '#{name}'" unless unbound_method
      define_method(name, unbound_method)
    end
  end

  instance_methods.each { |m| hide(m) }
end
