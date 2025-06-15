local ls = require('luasnip')
local fmta = require('luasnip.extras.fmt').fmta

local cv_1 =
"Identify position or type of work for which you are applying, how you learned of position, and why you’re interested in working for the organization. Draw reader in to ensure he or she reads the entire letter. Refer to any contact you’ve had with the organization, providing names of people with whom you have spoken."

local cv_2 =
"Indicate in the middle paragraphs that you understand position requirements and demonstrate you are a good match for the job. Highlight and expand upon experiences, skills, and interests stated in your resume."

local cv_3 =
"Thank the reader for their time and re-express your interest in the position. Depending on the application instructions for the position, indicate the timeframe within which you will contact the recipient to follow-up on your application."

-- Some very simple snippets for initializing preambles quickly and efficiently
return {
    -- for cover letter
    ls.s({ trig = ";cv ", regTrig = false, snippetType = "autosnippet" },
        fmta([[
        \documentclass{job}

        \begin{document}
        \begin{center}
        Alvin Lee \\
        347.353.4394 $|$ realee724@gmail.com $|$ linkedin.com/in/al0724
        \end{center}

        \hrule
        \medbreak

        Dear Hiring Manager, \medbreak

        <>

        <>

        <>

        \vspace{4ex}
        Best, \\
        Alvin Lee
        \end{document}
        ]], { ls.c(1, { ls.t "", ls.t(cv_1) }), ls.c(2, { ls.t "", ls.t(cv_2) }), ls.c(3, { ls.t "", ls.t(cv_3) }) })),
    -- for resume
    ls.s({ trig = ";res ", regTrig = false, snippetType = "autosnippet" },
        fmta([[
        \documentclass{job}
        \title{Alvin Lee}

        \begin{document}
        \maketitle
        <>

        \end{document}
        ]], { ls.i(0) })
    ),
    -- for notes
    ls.s({ trig = ";notes ", regTrig = false, snippetType = "autosnippet" },
        fmta([[
        %! TeX program = lualatex
        \documentclass{notes}
        \title{<>}

        \begin{document}
        \maketitle
        <>

        \end{document}
        ]], { ls.c(1, {
            ls.sn(nil, { ls.t "Lecture ", ls.i(1) }),
            ls.sn(nil, { ls.t "Homework ", ls.i(1) })
        }), ls.i(2) })
    ),
    -- for algorithm homework
    ls.s({ trig = ";alg ", regTrig = false, snippetType = "autosnippet" },
        fmta([[
        \documentclass{alg}
        \title{<>}
        \duedate{<>}
        \hwnum{<>}

        \begin{document}
        \maketitle
        \medbreak
        <>

        \end{document}
        ]], { ls.i(1), ls.i(2), ls.i(3), ls.i(0) })
    ),
}
