# STIG Compliance Program Implementation

In this project, we simulate the implementation of a comprehensive 
STIG compliance program for a DoD contractor environment.

**Starting State**: Organization has no formal STIG compliance process, 
systems are configured with vendor defaults

**End State**: Formal STIG policy enacted, 90%+ compliance achieved, 
continuous monitoring established, ATO package prepared

## Technologies Used
- Tenable (STIG/SCAP compliance scanning)
- STIG Viewer (finding analysis)
- PowerShell/Bash (automated hardening)
- Azure VMs (test environment)

## Why STIGs Matter
STIGs (Security Technical Implementation Guides) are the configuration 
standards required for all DoD information systems. Unlike vulnerability 
management which focuses on software flaws, STIG compliance ensures 
systems are configured securely from the ground up.

## Step 1: STIG Compliance Policy Draft Creation

This phase focuses on drafting a comprehensive STIG Compliance Policy as the foundation for organizational security hardening. Unlike vulnerability management which addresses software flaws, STIG compliance ensures systems are configured securely according to DoD standards from initial deployment. The draft policy establishes scope, responsibilities, remediation timelines, and compliance thresholds required for DoD contractor environments and ATO packages.

### Key Objectives
- Establish formal STIG compliance requirements for all organizational systems
- Define roles and responsibilities for STIG implementation and maintenance  
- Set compliance targets (90%+ for CAT I/II findings, 100% for CAT I)
- Create timeline framework for initial hardening and ongoing compliance
- Align with DoD contractor requirements and ATO preparation needs

### Policy Scope & Applicability
- **In Scope**: All Windows/Linux servers, workstations, network devices, databases
- **Standards**: DISA STIG baselines (Windows 10, Server 2019/2022, etc.)
- **Compliance Targets**: 100% CAT I, 95% CAT II, 90% CAT III findings
- **Timeline**: Initial compliance within 90 days, quarterly assessments thereafter

### Key Differences from Vulnerability Management

| **Aspect** | **Vulnerability Management** | **STIG Compliance** |
|------------|----------------------------|-------------------|
| **Focus** | Software flaws and patches | Secure configuration baselines |
| **Standards** | CVE database, vendor advisories | DISA STIGs, NIST guidelines |
| **Tools** | Nessus, Qualys, Rapid7 | SCAP scanners, STIG Viewer |
| **Timeline** | Reactive (post-disclosure) | Proactive (baseline hardening) |
| **Compliance** | Risk-based prioritization | Mandatory DoD requirements |
| **Documentation** | Scan reports, patch records | ATO packages, compliance evidence |

[Draft Policy](https://docs.google.com/document/d/1SGvdBBxNLzyEyMFMLnpl6cB4cqjgaKypqxL-qpino8o/edit?tab=t.0#heading=h.oo3jgk9t31gg)

### Next Steps
1. **Stakeholder Review**: Share draft policy with server team, system administrators, and management
2. **Feedback Integration**: Incorporate practical concerns and implementation challenges
3. **Timeline Refinement**: Adjust remediation windows based on operational constraints
4. **Tool Selection**: Identify SCAP scanning tools and STIG automation platforms
5. **Resource Planning**: Determine staffing and budget requirements for compliance program

***UNDER CONSTRUCTION***

![image](https://github.com/user-attachments/assets/23a26854-f70e-49c8-8dbf-0891069f6dc0)
