module ApplicationHelper
    def flash_class(key)
        case key.to_sym
        when :notice   then "success"
        when :alert    then "danger"
        when :warning  then "warning"
        when :info     then "info"
        else "primary"
        end
    end
end
