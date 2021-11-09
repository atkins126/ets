#pragma once

#include <boost/fusion/support/config.hpp>
#include <fusion/algorithm/iteration/detail/concate.hpp>

namespace ets { namespace fusion
{
    namespace result_of
    {
        template <typename Sequence, typename F>
        struct concate
        {
            typedef void type;
        };
    }

    template <typename Sequence, typename F>
    inline void
    concate(Sequence& seq, F const& f)
    {
        detail::concate(seq, f);
    }

    template <typename Sequence, typename F>
    inline void
    concate(Sequence const& seq, F const& f)
    {
        detail::concate(seq, f);
    }
}}
