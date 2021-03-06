// Copyright (c) 2106 Klemens D. Morgenstern
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

#ifndef BOOST_PROCESS_WINDOWS_IS_RUNNING_HPP
#define BOOST_PROCESS_WINDOWS_IS_RUNNING_HPP

#include <process/detail/config.hpp>
#include <system_error>
#include <cstdlib>
#include <boost/detail/winapi/process.hpp>

namespace ets { namespace process { namespace detail { namespace windows {

BOOST_CONSTEXPR_OR_CONST static ::boost::detail::winapi::DWORD_ still_active = 259;


struct child_handle;

inline bool is_running(const child_handle &p, int & exit_code)
{
    ::boost::detail::winapi::DWORD_ code;
    //single value, not needed in the winapi.
    if (!::boost::detail::winapi::GetExitCodeProcess(p.process_handle(), &code))
        ::ets::process::detail::throw_last_error("GetExitCodeProcess() failed");

    if (code == still_active)
        return true;
    else
    {
        exit_code = code;
        return false;
    }    
}

inline bool is_running(const child_handle &p, int & exit_code, std::error_code &ec) BOOST_NOEXCEPT
{
    ::boost::detail::winapi::DWORD_ code;
    //single value, not needed in the winapi.
    if (!::boost::detail::winapi::GetExitCodeProcess(p.process_handle(), &code))
        ec = ::ets::process::detail::get_last_error();
    else
        ec.clear();

    if (code == still_active)
        return true;
    else
    {
        exit_code = code;
        return false;
    }    
}

inline bool is_running(int code)
{
    return code == still_active;
}

inline int eval_exit_status(int in ) {return in;}

}}}}

#endif
