/*
    Copyright (c) 2021-2031 Steven Shi

    ETS(Extended Tool Set)，可扩展工具集。

    本工具软件是开源自由软件，您可以遵照 MIT 协议，修改和发布此程序。
    发布此库的目的是希望其有用，但不做任何保证。
    如果将本库用于商业项目，由于本库中的Bug，而引起的任何风险及损失，本作者不承担任何责任。

    开源地址: https://github.com/ets-ddui/ets
    开源协议: The MIT License (MIT)
    作者邮箱: xinghun87@163.com
    官方博客：https://blog.csdn.net/xinghun61
*/
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
