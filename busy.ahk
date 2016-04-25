^w::
    loop{
        variable_names  :=  "hash|host|hostname|href|origin|pathname|port|protocol|search"
        class_name  :=  "location"

        StringSplit, variable_names_array, variable_names, "|"

        loop, %variable_names_array0%{
            Random, delay, 80, 120
            SetKeyDelay, %delay%
            current :=  variable_names_array%a_index%
            Send, %class_name%.prototype.
            Random, r, 800, 1300
            Sleep, %r%
            Send, get_
            Random, r, 800, 1300
            Sleep, %r%
            Send, %current%
            Random, r, 800, 1300
            Sleep, %r%
            Send, {space}={space}
            Random, r, 800, 1300
            Sleep, %r%
            Send, function(){{}{enter}
            Random, r, 800, 1300
            Sleep, %r%
            Send, {tab}
            Random, r, 800, 1300
            Sleep, %r%
            Send, return this.
            Random, r, 800, 1300
            Sleep, %r%
            Send, %current%;{enter}
            Random, r, 800, 1300
            Sleep, %r%
            Send, {BackSpace}{}}
            Random, r, 800, 1300
            Sleep, %r%
            Send, {enter}{enter}
            Random, r, 800, 1300
            Sleep, %r%

            Send, %class_name%.prototype.
            Random, r, 800, 1300
            Sleep, %r%
            Send, set_
            Random, r, 800, 1300
            Sleep, %r%
            Send, %current%
            Random, r, 800, 1300
            Sleep, %r%
            Send, {space}={space}
            Random, r, 800, 1300
            Sleep, %r%
            Send, function(%current%){{}{enter}
            Random, r, 800, 1300
            Sleep, %r%
            Send, {tab}
            Random, r, 800, 1300
            Sleep, %r%
            Send, this.
            Random, r, 800, 1300
            Sleep, %r%
            Send, %current% ={space}
            Random, r, 800, 1300
            Sleep, %r%
            Send, %current%;{enter}
            Random, r, 800, 1300
            Sleep, %r%
            Send, return this;{enter}
            Random, r, 800, 1300
            Sleep, %r%
            Send, {BackSpace}{}}
            Random, r, 800, 1300
            Sleep, %r%
            Send, {enter}{enter}
            Random, r, 800, 1300
            Sleep, %r%
        }
    }
return

esc::
    ExitApp
    return

numpad0::
    Pause, toggle
    return