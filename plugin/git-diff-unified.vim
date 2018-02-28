" Copyright (C) 2018  Masafumi Yokoyama <yokoyama@clear-code.com>
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.

function! s:GitDiffUnified(...)
  if a:0 >= 1
    let l:args = a:1
  else
    let l:args = ''
  end
  call system('git rev-parse')
  if v:shell_error != 0
    echoe 'Not a git repository.'
    return
  end
  let l:reponame = fnamemodify(systemlist('git rev-parse --show-toplevel')[0], ':t')
  let l:head = systemlist('git rev-parse --short HEAD')[0]
  let l:timestamp = strftime('%Y%m%d%H%M%S')
  let l:bufname = l:reponame . '-' . l:head . '-' . l:timestamp . '.diff'
  if isdirectory('/tmp')
    let l:bufname = '/tmp/' . l:bufname
  end
  let l:diff = system('git diff ' . l:args)
  if v:shell_error != 0
    echoe 'Invalid option: ' . l:args
    return
  end
  if l:diff == ""
    echom 'no changes.'
    return
  end
  :execute 'new '.l:bufname
  normal O
  call append('.', split(l:diff, '\n'))
  normal dd
  if isdirectory('/tmp')
    :write
  end
endfunction

command! -nargs=? GitDiffUnified :call s:GitDiffUnified(<f-args>)
