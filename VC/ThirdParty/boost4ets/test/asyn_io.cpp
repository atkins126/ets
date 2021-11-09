#define BOOST_ASIO_HAS_MOVE 1 //boost::asio对右值引用的版本识别似乎有问题，VC2010好像支持，这里手动开启

#include <boost/asio.hpp>
#include <process/async_pipe.hpp>
#include <process/child.hpp>
#include <process/search_path.hpp>
#include <process/io.hpp>

int main(int argc, char* argv[])
{
    boost::asio::io_service ios;
    std::vector<char> buf(100);

    ets::process::async_pipe ap(ios);

    ets::process::child c(ets::process::search_path("cmd"), "/?", ets::process::std_out > ap);

    boost::asio::async_read(ap, boost::asio::buffer(buf),
        [&buf](const boost::system::error_code &ec, std::size_t size){
            std::cout << std::string(buf.begin(), buf.begin() + size);
        });

    ios.run();
    c.wait();
    int result = c.exit_code();

    return result;
}
