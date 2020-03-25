Security check template
----

For every release, a filled in copy of the template [should be checked in and tagged](https://github.com/WorldHealthOrganization/app/issues/269#issuecomment-603653099).

### [ ] System Boundary
Diagram of:
- [ ] internal services
- [ ] components
- [ ] connections to external services and systems.

### [ ] APIs and Interconnection (external systems and services)
- [ ] Data types transmitted to, stored by, or processed by the API or system/service
- [ ] Data categorization/impact assessment
- [ ] Connectivity Details:
  - Protocols + Ports
  - Encryption
- [ ] Agreements (SLAs or licenses)

### [ ] Infrastructure: List of IaaS services
- [ ] compute
- [ ] network
- [ ] storage
- [ ] etc? :construction:

### [ ] Data Flow
  - [ ] Identify where data is to be processed, stored, or transmitted
  - [ ] Delineate how data comes in and out of the system boundary
  - [ ] Any notes for privileged and non-privileged access

### [ ] Cryptography
  - [ ] Validate: Data at Rest
  - [ ] Validate: Internal Transmission
  - [ ] Validate: External Transmission
