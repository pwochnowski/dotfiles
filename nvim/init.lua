
package.path = '/home/paulw/repos/fzy-lua-native/lua/?.lua;' .. 'lua/?.lua;' .. package.path
package.cpath = '/home/paulw/repos/fzy-lua-native/static/?.so;' .. package.cpath

require("custom.reload")
require("paulw")
