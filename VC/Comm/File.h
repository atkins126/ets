#pragma once

#include <stdarg.h>
#include <vector>
#include <string>
#include <map>
#include <Shlwapi.h>

#if defined(WIN32)
    #include <Windows.h>
#else
    #include <iconv.h>
#endif

namespace vcl4c
{
    namespace file
    {
        inline const bool IsDir(const std::string &p_sPath)
        {
            DWORD iAttr = ::GetFileAttributes(p_sPath.c_str());
            return (iAttr != INVALID_FILE_ATTRIBUTES) && (iAttr & FILE_ATTRIBUTE_DIRECTORY);
        }

        inline void Split(std::string &p_sPath, std::string &p_sName, const std::string &p_sFullName)
        {
            std::string::size_type nPos = p_sFullName.find_last_of("\\/");
            if (nPos == std::string::npos)
            {
                p_sPath.erase();
                p_sName = p_sFullName;
            }
            else
            {
                /* TODO: 针对根目录、网络路径、路径间包含多个分隔符的情况有待完善 */
                p_sPath = p_sFullName.substr(0, nPos);
                p_sName = p_sFullName.substr(nPos + 1);
            }
        }

        inline void CreateFilePath(const char *p_sDirectory)
        {
            if(!::PathFileExistsA(p_sDirectory))
            {
                //创建父目录
                std::string sParentPath, sDirectoryName;
                Split(sParentPath, sDirectoryName, p_sDirectory);
                if (!sParentPath.empty())
                {
                    CreateFilePath(sParentPath.c_str());
                }

                //创建当前目录
                ::CreateDirectoryA(p_sDirectory, NULL);
            }
        }

        inline const bool FileExists(const std::string &p_sFile)
        {
            DWORD iAttr = ::GetFileAttributes(p_sFile.c_str());
            if (iAttr != INVALID_FILE_ATTRIBUTES)
            {
                return 0 == (iAttr & FILE_ATTRIBUTE_DIRECTORY);
            }
            else
            {
                DWORD iLastError = ::GetLastError();

                return (ERROR_FILE_NOT_FOUND != iLastError)
                    && (ERROR_PATH_NOT_FOUND != iLastError)
                    && (ERROR_INVALID_NAME != iLastError)
                    && [] (const std::string &p_sFile) throw() -> bool
                    {
                        WIN32_FIND_DATA fd = {0};
                        HANDLE hFindFirst = ::FindFirstFile(p_sFile.c_str(), &fd);
                        if (INVALID_HANDLE_VALUE != hFindFirst)
                        {
                            ::FindClose(hFindFirst);

                            return 0 == (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY);
                        }

                        return false;
                    }(p_sFile);
            }
        }

        inline const bool Read(std::string &p_sResult, const std::string &p_sFile)
        {
            FILE *f = ::fopen(p_sFile.c_str(), "rb");
            if (nullptr == f)
            {
                return false;
            }

            ::fseek(f, 0, SEEK_END);
            long iSize = ::ftell(f);
            if (iSize < 0)
            {
                ::fclose(f);
                return false;
            }
            ::fseek(f, 0, SEEK_SET);

            p_sResult.resize(iSize);
            long iRead = ::fread(const_cast<char *>(p_sResult.c_str()), 1, iSize, f);
            ::fclose(f);

            return true;
        }

        inline const bool Write(std::string &p_sValue, const std::string &p_sFile, const bool p_bAppend = true)
        {
            ::std::string sPath, sName;
            Split(sPath, sName, p_sFile);
            if (!sPath.empty() && "." != sPath)
            {
                CreateFilePath(sPath.c_str());
            }

            FILE *pFile = ::fopen(p_sFile.c_str(), p_bAppend ? "a+b" : "wb");
            if (nullptr == pFile)
            {
                return false;
            }

            size_t iSize = fwrite(p_sValue.c_str(), 1, p_sValue.size(), pFile);
            if (p_sValue.size() != iSize)
            {
                fclose(pFile);
                pFile = nullptr;

                return false;
            }

            fclose(pFile);
            pFile = nullptr;

            return true;
        }

    }
}
