/*=============================================================================
    Copyright (c) 2001-2011 Joel de Guzman

    Distributed under the Boost Software License, Version 1.0. (See accompanying
    file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

    This is an auto-generated file. Do not edit!
==============================================================================*/
namespace ets { namespace fusion { namespace detail
{
    template <>
    struct append_set<1>
    {
        template <typename I0, typename Element>
        struct apply
        {
            typedef typename boost::fusion::result_of::next<I0>::type I1;
            typedef typename boost::fusion::result_of::value_of<I0>::type T0;
            typedef boost::fusion::set<T0, Element> type;
        };
    };
    template <>
    struct append_set<2>
    {
        template <typename I0, typename Element>
        struct apply
        {
            typedef typename boost::fusion::result_of::next<I0>::type I1; typedef typename boost::fusion::result_of::next<I1>::type I2;
            typedef typename boost::fusion::result_of::value_of<I0>::type T0; typedef typename boost::fusion::result_of::value_of<I1>::type T1;
            typedef boost::fusion::set<T0 , T1, Element> type;
        };
    };
    template <>
    struct append_set<3>
    {
        template <typename I0, typename Element>
        struct apply
        {
            typedef typename boost::fusion::result_of::next<I0>::type I1; typedef typename boost::fusion::result_of::next<I1>::type I2; typedef typename boost::fusion::result_of::next<I2>::type I3;
            typedef typename boost::fusion::result_of::value_of<I0>::type T0; typedef typename boost::fusion::result_of::value_of<I1>::type T1; typedef typename boost::fusion::result_of::value_of<I2>::type T2;
            typedef boost::fusion::set<T0 , T1 , T2, Element> type;
        };
    };
    template <>
    struct append_set<4>
    {
        template <typename I0, typename Element>
        struct apply
        {
            typedef typename boost::fusion::result_of::next<I0>::type I1; typedef typename boost::fusion::result_of::next<I1>::type I2; typedef typename boost::fusion::result_of::next<I2>::type I3; typedef typename boost::fusion::result_of::next<I3>::type I4;
            typedef typename boost::fusion::result_of::value_of<I0>::type T0; typedef typename boost::fusion::result_of::value_of<I1>::type T1; typedef typename boost::fusion::result_of::value_of<I2>::type T2; typedef typename boost::fusion::result_of::value_of<I3>::type T3;
            typedef boost::fusion::set<T0 , T1 , T2 , T3, Element> type;
        };
    };
    template <>
    struct append_set<5>
    {
        template <typename I0, typename Element>
        struct apply
        {
            typedef typename boost::fusion::result_of::next<I0>::type I1; typedef typename boost::fusion::result_of::next<I1>::type I2; typedef typename boost::fusion::result_of::next<I2>::type I3; typedef typename boost::fusion::result_of::next<I3>::type I4; typedef typename boost::fusion::result_of::next<I4>::type I5;
            typedef typename boost::fusion::result_of::value_of<I0>::type T0; typedef typename boost::fusion::result_of::value_of<I1>::type T1; typedef typename boost::fusion::result_of::value_of<I2>::type T2; typedef typename boost::fusion::result_of::value_of<I3>::type T3; typedef typename boost::fusion::result_of::value_of<I4>::type T4;
            typedef boost::fusion::set<T0 , T1 , T2 , T3 , T4, Element> type;
        };
    };
    template <>
    struct append_set<6>
    {
        template <typename I0, typename Element>
        struct apply
        {
            typedef typename boost::fusion::result_of::next<I0>::type I1; typedef typename boost::fusion::result_of::next<I1>::type I2; typedef typename boost::fusion::result_of::next<I2>::type I3; typedef typename boost::fusion::result_of::next<I3>::type I4; typedef typename boost::fusion::result_of::next<I4>::type I5; typedef typename boost::fusion::result_of::next<I5>::type I6;
            typedef typename boost::fusion::result_of::value_of<I0>::type T0; typedef typename boost::fusion::result_of::value_of<I1>::type T1; typedef typename boost::fusion::result_of::value_of<I2>::type T2; typedef typename boost::fusion::result_of::value_of<I3>::type T3; typedef typename boost::fusion::result_of::value_of<I4>::type T4; typedef typename boost::fusion::result_of::value_of<I5>::type T5;
            typedef boost::fusion::set<T0 , T1 , T2 , T3 , T4 , T5, Element> type;
        };
    };
    template <>
    struct append_set<7>
    {
        template <typename I0, typename Element>
        struct apply
        {
            typedef typename boost::fusion::result_of::next<I0>::type I1; typedef typename boost::fusion::result_of::next<I1>::type I2; typedef typename boost::fusion::result_of::next<I2>::type I3; typedef typename boost::fusion::result_of::next<I3>::type I4; typedef typename boost::fusion::result_of::next<I4>::type I5; typedef typename boost::fusion::result_of::next<I5>::type I6; typedef typename boost::fusion::result_of::next<I6>::type I7;
            typedef typename boost::fusion::result_of::value_of<I0>::type T0; typedef typename boost::fusion::result_of::value_of<I1>::type T1; typedef typename boost::fusion::result_of::value_of<I2>::type T2; typedef typename boost::fusion::result_of::value_of<I3>::type T3; typedef typename boost::fusion::result_of::value_of<I4>::type T4; typedef typename boost::fusion::result_of::value_of<I5>::type T5; typedef typename boost::fusion::result_of::value_of<I6>::type T6;
            typedef boost::fusion::set<T0 , T1 , T2 , T3 , T4 , T5 , T6, Element> type;
        };
    };
    template <>
    struct append_set<8>
    {
        template <typename I0, typename Element>
        struct apply
        {
            typedef typename boost::fusion::result_of::next<I0>::type I1; typedef typename boost::fusion::result_of::next<I1>::type I2; typedef typename boost::fusion::result_of::next<I2>::type I3; typedef typename boost::fusion::result_of::next<I3>::type I4; typedef typename boost::fusion::result_of::next<I4>::type I5; typedef typename boost::fusion::result_of::next<I5>::type I6; typedef typename boost::fusion::result_of::next<I6>::type I7; typedef typename boost::fusion::result_of::next<I7>::type I8;
            typedef typename boost::fusion::result_of::value_of<I0>::type T0; typedef typename boost::fusion::result_of::value_of<I1>::type T1; typedef typename boost::fusion::result_of::value_of<I2>::type T2; typedef typename boost::fusion::result_of::value_of<I3>::type T3; typedef typename boost::fusion::result_of::value_of<I4>::type T4; typedef typename boost::fusion::result_of::value_of<I5>::type T5; typedef typename boost::fusion::result_of::value_of<I6>::type T6; typedef typename boost::fusion::result_of::value_of<I7>::type T7;
            typedef boost::fusion::set<T0 , T1 , T2 , T3 , T4 , T5 , T6 , T7, Element> type;
        };
    };
    template <>
    struct append_set<9>
    {
        template <typename I0, typename Element>
        struct apply
        {
            typedef typename boost::fusion::result_of::next<I0>::type I1; typedef typename boost::fusion::result_of::next<I1>::type I2; typedef typename boost::fusion::result_of::next<I2>::type I3; typedef typename boost::fusion::result_of::next<I3>::type I4; typedef typename boost::fusion::result_of::next<I4>::type I5; typedef typename boost::fusion::result_of::next<I5>::type I6; typedef typename boost::fusion::result_of::next<I6>::type I7; typedef typename boost::fusion::result_of::next<I7>::type I8; typedef typename boost::fusion::result_of::next<I8>::type I9;
            typedef typename boost::fusion::result_of::value_of<I0>::type T0; typedef typename boost::fusion::result_of::value_of<I1>::type T1; typedef typename boost::fusion::result_of::value_of<I2>::type T2; typedef typename boost::fusion::result_of::value_of<I3>::type T3; typedef typename boost::fusion::result_of::value_of<I4>::type T4; typedef typename boost::fusion::result_of::value_of<I5>::type T5; typedef typename boost::fusion::result_of::value_of<I6>::type T6; typedef typename boost::fusion::result_of::value_of<I7>::type T7; typedef typename boost::fusion::result_of::value_of<I8>::type T8;
            typedef boost::fusion::set<T0 , T1 , T2 , T3 , T4 , T5 , T6 , T7 , T8, Element> type;
        };
    };
}}}
