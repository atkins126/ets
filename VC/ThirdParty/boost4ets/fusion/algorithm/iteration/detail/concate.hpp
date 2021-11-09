#pragma once

#include <boost/fusion/support/config.hpp>
#include <boost/fusion/sequence/intrinsic/begin.hpp>
#include <boost/fusion/sequence/intrinsic/end.hpp>
#include <boost/fusion/iterator/equal_to.hpp>
#include <boost/fusion/iterator/next.hpp>
#include <boost/fusion/iterator/deref.hpp>
#include <boost/fusion/iterator/distance.hpp>
#include <boost/fusion/support/category_of.hpp>
#include <boost/mpl/bool.hpp>

namespace ets { namespace fusion {
namespace detail
{
    template <typename First, typename Next, typename Last, typename F>
    inline void
    concate_linear(First const& first, Next const& next, Last const& last, F const& f)
    {
        f(*first, *next);
        detail::concate_linear(next, boost::fusion::next(next), last, f);
    }

    template <typename First, typename Last, typename F>
    inline void
    concate_linear(First const& first, Last const& next, Last const& last, F const& f)
    {
    }

    template <typename Sequence, typename F>
    inline void
    concate(Sequence& seq, F const& f)
    {
        auto first = boost::fusion::begin(seq);
        auto next = boost::fusion::next(first);
        auto end = boost::fusion::end(seq);

        detail::concate_linear(first, next, end, f);
    }
}}}
