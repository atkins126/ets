// Copyright (c) 2016 Klemens D. Morgenstern
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)


#ifndef BOOST_PROCESS_DETAIL_WINDOWS_ENV_INIT_HPP_
#define BOOST_PROCESS_DETAIL_WINDOWS_ENV_INIT_HPP_

#include <boost/detail/winapi/error_codes.hpp>
#include <boost/detail/winapi/process.hpp>


#include <process/detail/config.hpp>
#include <process/detail/handler_base.hpp>
#include <process/environment.hpp>

namespace ets { namespace process { namespace detail { namespace windows {

template<typename Char>
struct env_init : public ::ets::process::detail::handler_base
{
    ets::process::basic_environment<Char> env;

    env_init(ets::process::basic_environment<Char> && env) : env(std::move(env)) {};
    env_init(const ets::process::basic_environment<Char> & env) : env(env) {};

    BOOST_CONSTEXPR_OR_CONST static ::boost::detail::winapi::DWORD_ creation_flag(char)    {return 0u;}
    BOOST_CONSTEXPR_OR_CONST static ::boost::detail::winapi::DWORD_ creation_flag(wchar_t)
    {
       return ::boost::detail::winapi::CREATE_UNICODE_ENVIRONMENT_;
    }

    template <class WindowsExecutor>
    void on_setup(WindowsExecutor &exec) const
    {
        auto e = env.native_handle();
        if (*e == null_char<char>())
        {
            exec.set_error(std::error_code(::boost::detail::winapi::ERROR_BAD_ENVIRONMENT_, std::system_category()),
                    "Empty Environment");
        }

        exec.env = e;
        exec.creation_flags |= creation_flag(Char());
    }

};

}}}}



#endif /* BOOST_PROCESS_DETAIL_WINDOWS_ENV_INIT_HPP_ */
