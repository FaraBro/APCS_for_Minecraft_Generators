In this doc file is described all possible actions with this APCS with keyboard (whose conneted to any display or something)  
For some actions user need be Super User  
[Who administator/super user?](/doc/en_US/users.md)

The keys and their functions are presented below
- E -- Emergency Stop. Self Explanatory. Requires administrator privileges by default. Emergency stop all gens and monitoring to ensure that they are switched off. In this case, the PID controller is disabled, as it is not needed 
- M -- Manual Mode. Switching the APCS to manual (M) state.
- C -- Shutdown. Requires administrator privileges by default. Like SysReq+C shutdown APCS, while stopping all gens. Give this privilege for random people is dangerous!
- O -- Reset APCS state and switching one to O (Operational) state. Give privilege to reset Emergency state for random people is dangerous. Administrator privileges may be required (depending on the state of the APCS)
- R -- Reboot APCS. Requires administrator privileges by default. Give this privilege for random people is dangerous!
