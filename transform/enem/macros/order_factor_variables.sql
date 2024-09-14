{% {% macro order_factor_variable(var) %}
    case 
        when {{ var }} = 'A' then 1
        when {{ var }} = 'B' then 2
        when {{ var }} = 'C' then 3
        when {{ var }} = 'D' then 4
        when {{ var }} = 'E' then 5
        when {{ var }} = 'F' then 6
        when {{ var }} = 'G' then 7
        when {{ var }} = 'H' then 8
        when {{ var }} = 'I' then 9
        when {{ var }} = 'J' then 10
        when {{ var }} = 'K' then 11
        when {{ var }} = 'L' then 12
        when {{ var }} = 'M' then 13
        when {{ var }} = 'N' then 14
        when {{ var }} = 'O' then 15
        when {{ var }} = 'P' then 16
        when {{ var }} = 'Q' then 17
    end
{% endmacro %}%}