#pragma once

#include <boost/fusion/support/config.hpp>

namespace ets { namespace fusion
{
    namespace result_of
    {
        template <typename Sequence, typename F>
        struct concate;
    }

    template <typename Sequence, typename F>
    inline void
    concate(Sequence& seq, F const& f);

    template <typename Sequence, typename F>
    inline void
    concate(Sequence const& seq, F const& f);
}}
