-- [[
-- @cond ___LICENSE___
--
-- Copyright (c) 2016-2018 Zefiros Software.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
-- @endcond
-- ]]
    project "hwloc"
        kind "StaticLib"

        files {
            "hwloc/**.c"
        }

        removefiles {
            "hwloc/topology-*.c"
        }

        files {
            "hwloc/topology-noos.c",
            "hwloc/topology-synthetic.c",
            "hwloc/topology-x86.c",
            "hwloc/topology-xml-nolibxml.c",
            "hwloc/topology-xml.c"
        }

        if os.istarget("windows") then
            files {
                "hwloc/topology-windows.c"                
            }

            characterset("MBCS")

            filter "architecture:x86"
                undefines "HWLOC_X86_64_ARCH"
                defines "HWLOC_X86_32_ARCH=1"

            filter {}
        elseif os.istarget("linux") or os.istarget("macosx") then
            files {
                "hwloc/topology-hardwired.c"
            }

            if os.istarget("linux") then
                files { "hwloc/topology-linux.c" }
            else
                files { "hwloc/topology-darwin.c" }
            end

            defines {
                "RUNSTATEDIR=\"/usr/local/var/run\""
            }

            links "pthread"
        end

        includedirs {
            "include",
            "hwloc"
        }

        zpm.export(function()
            includedirs "include"

            filter "architecture:x86"
                undefines "HWLOC_X86_64_ARCH"
                defines "HWLOC_X86_32_ARCH=1"

            filter {}
        end)

        filter {}
