# erl_hibernate
> 测试 hibernate 参数对系统的影响

官方用法解释：

Puts the calling process into a wait state where its memory allocation has been reduced as much as possible.

This is useful if the process does not expect to receive any messages soon.

### 测试环境
win7,otp-22.0
使用不同的模块同时新建10w个gen_server
```
normal_svr
init([]) ->
  {ok, #state{}}.
  
hibernate_svr

init([]) ->
  {ok, #state{}, hibernate}.
```

### 测试结果 
##### hibernate_svr
```
rebar.config
{erl_opts, [
  {d, hibernate},
  debug_info
]}.

rebar compile
werl -pa ebin -P 300000 -s erl_hibernate
1> erlang:memory().

[{total,209592416},
 {processes,170086224},
 {processes_used,170085280},
 {system,18446744073749057808},
 {atom,3699033},
 {atom_used,3694166},
 {binary,692816},
 {code,4682355},
 {ets,351424}]

```

### normal_svr
```
rebar.config
{erl_opts, [
  %{d, hibernate},
  debug_info
]}.

rebar compile
werl -pa ebin -P 300000 -s erl_hibernate
1> erlang:memory().

[{total,369103040},
 {processes,330034704},
 {processes_used,330033760},
 {system,39068336},
 {atom,3404049},
 {atom_used,3393117},
 {binary,624272},
 {code,4615561},
 {ets,350464}]

```

### 结论
在使用过程中，还是尽量用到hibernate，可以可以省一半内存呢