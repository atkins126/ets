#pragma once

#include <boost/fusion/support/config.hpp>
#include <fusion/container/set/detail/append_set.hpp>
//#include <boost/fusion/container/set/detail/convert_impl.hpp>
#include <boost/fusion/container/set/set.hpp>
#include <boost/fusion/sequence/intrinsic/begin.hpp>
#include <boost/fusion/sequence/intrinsic/size.hpp>

namespace ets { namespace fusion
{
    namespace result_of
    {
        template <typename Sequence, typename Element>
        struct append_set
        {
            typedef typename boost::fusion::result_of::has_key<Sequence, Element> has_key;

            typedef typename detail::append_set<boost::fusion::result_of::size<Sequence>::value> gen;

            typedef typename std::conditional<
                has_key::value,
                Sequence,
                typename gen::template apply<typename boost::fusion::result_of::begin<Sequence>::type, Element>::type
            >::type type;
        };
    }
}}
