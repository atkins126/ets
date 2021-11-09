#pragma once

#include <boost/preprocessor/iterate.hpp>
#include <boost/preprocessor/repetition/enum_params.hpp>
#include <boost/preprocessor/repetition/enum_binary_params.hpp>
#include <boost/preprocessor/repetition/repeat.hpp>
#include <boost/preprocessor/cat.hpp>
#include <boost/preprocessor/inc.hpp>
#include <boost/preprocessor/dec.hpp>
#include <boost/fusion/container/set/set.hpp>
#include <boost/fusion/iterator/value_of.hpp>
#include <boost/fusion/iterator/deref.hpp>
#include <boost/fusion/iterator/next.hpp>

namespace ets { namespace fusion { namespace detail
{
    template <int size>
    struct append_set;

    template <>
    struct append_set<0>
    {
        template <typename Iterator, typename Element>
        struct apply
        {
            typedef boost::fusion::set<Element> type;
        };
    };
}}}

#if !defined(BOOST_FUSION_DONT_USE_PREPROCESSED_FILES)
#include <fusion/container/set/detail/cpp03/preprocessed/append_set.hpp>
#else
#error Not implement
#endif // BOOST_FUSION_DONT_USE_PREPROCESSED_FILES
