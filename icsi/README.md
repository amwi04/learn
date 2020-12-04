# ICSI certification

## Module 1

### Basics of networking

#### OSI model

1. Application
2. Presentation
3. Session
4. transport
5. network
6. data link
7. physical

### Threat Classification

1. Intrusion
2. Blocking
3. Malware

### Hacking Terminology

1. white hat = find weak point and report
2. black hat = Cause damage

### Parameter Security Approach

### Layered Security Approach

### Hybrid Security Approach

## Module 2

### Denial of Service

1. SYN flood = Sending flood of pings
2. Smurf Attack = most popular we send a ICMP error packet in the network from which everyone will reply with ICMP packets which case chain reaction in network
3. Ping of death = send a huge tcp packet which target cannot handle
4. UDP flood = Randomly flooding udp packets so the target system cannot ack the actual user
-low orbit ion canon
        -high orbit ion canon

### Buffer over flow = overflow the buffer with huge input

### IP Spoofing = proxying our ip with the trusted ip in the network to gain access

to avoid ip spoofing in ubuntu server
/etc/sysctl
change net.ip4.conf.default.rp_filter=1
net.ip4.conf.all.rp_filter=1

### Session Hijacking

Man in middle of steal session key

## Module 3

### Firewall

1. Packet filtering
    - check packet packet for thread
2. State packet filtering
    - Simple words this type know the content in the packet from where it coming from the data it needs and all.
    - So SYN and ping flood attacks have low probability to damage
    - it know the source of the packet and can determine can the packet be trusted

3. Application Gateway
    - Filters port and IP so that admins can fine tune who can and cannot get access
    - problem flood of connection request can do some damage
4. Circuit level gateway
    - Similar to Application gateway but more secure and generally implemented in high end equipment
    - it also acts as a proxy
    - communication happens only when id or ip is verified

### Firewall Implementation

1. host based
    - host based is also called as network host-based
    - it's a software which can installed on a machine so if os is not hardened that might be problem it may be inexpensive or free
        * Ensure all patched are updated
        * Uninstalling unneeded application or utilities
        * Closing unused ports
        * Turning off all unused services

2. Dual-Homed Host
    - actual server is in between gateway and network as proxy which act as a firewall

3. Router-Based Firewall
    - Router has some kind of firewall some kind of filtering.

4. Screened Hosts
    - Screened host is basically a combination of firewall

### Proxy Servers

- Proxy servers to hide internal network

1. NAT ( network address translation )
    -   allow internal and external communication with restriction.
    - it hides internal network address

### Windows Firewalls

- from windows server 2008 all versions have firewall buildin

### Linux firewall

- iptables
    * 1st introduced in version 2.2
    * basic ip packets filtering
        - iptables -F
        - iptables -N block
        - iptables -A block -m state --state ESTABLISHED,RELATED -j ACCEPT
        - to list = iptables -L
        - eg. = iptables -A INPUT -p tcp -dport ssh -j ACCEPT
        * A =  Append the rule in rule chain
        * -L = List the current filter
        * -p = Protocol
        * --dport = the destination port requires for the rule single or range
        * -i =  only match if the packet is coming in on the specified interface
        * -v = Verbose output
        * -s/--source = address source specification
        * -d/--destination = address destination specification

## Module 4

### IDS Concepts

- 6 basic approaches to intrusion-detection and prevention.

#### Pre-emptive Blocking

- Also called as banishment vigilance
- Basically it find particular IP address as the source which is scanning some port frequently then this would just block that IP
- Problem is legitimate user can be blocked
- Generally the software triggers a alert which then can be resolved by human administrator to block or ignore the IP address

#### Anomaly Detection

- Anomaly detection involved actual software that works to detect intrusion attempt and to notify the administrator.
- Software can profile user, group or application and track all activities or behavior is considered an anomaly it also referred as "trace back"

1. Threshold monitoring
    - Its give a threshold which is acceptable
    - Its harder to give threshold value and time frame at which threshold should check
    - This can result high rate of false positive
2. Resource profiling
    - resource profiling measures system wise resource and develope a usage profile
    - It can give false positive as sometimes workload is increased rather than an attempt to breach security.
3. User/Group work profiling
    - User level resource profiling
4. Executable profiling
    - profiling is done on software level as critical software will have high level of privilege than a user so attacking software or executable will have higher impact


### Components and Processes of IDS

- Active IPS = IPS=> Intrusion prevention System
- HIDS => Host-based Intrusion-detection System
- NIDS => Network-based Intrusion-detection System
- NIPS => Network-based Intrusion prevention System

### Implementing IDS

1. Snort
    - open source Host based IDS.
    - snort works on 3 modes : Sniffer,packet logger,network intrusion detection

    1. Sniffer => console mode display continuos stream of packets on screen
    2. Packet logger => Same like sniffer but its written to file
    3. network intrusion detection => Snort uses heuristic approach to detect anomaly
        - Means Rule-based and learns form experience .

2. Cisco Intrusion detection and prevention.
    - Cisco IDS 4000 series sensor and Cisco Catalyst 6500 series IDS Module

### Honeypots

- Honeypot is a server in the same network which simulate a valuable server so attacker will try to attack honeypot server rather than original server and the intrusion can be detected and stopped.

#### Specter

- Specter js a software honeypot solution.
    - which simulate major protocols like http/s, ftp, POP3, SMTP etc
    Modes are :-
        1. Open: it behaves like badly configured server in terms of security
        2. Secure: system behaves like secure sever.
        3. Failing: It cause the system to behave like server has various hardware and software problems
        4. Strange: System behaves in unpredictable ways to attracts attackers.
        5. Aggressive: In this mode system actively tries to trace back the intruder.

    - In all modes specter logs activity is recorded
    - it also tries to leave traces on attackers machines which provides clear evidence for any criminal activities.

    - Users also use fake password so hacker can try to crack the password

    1. Easy: password is easy to crack leading intruder to believe he has cracked the legitimate logon and will be monitored when trying to get in legitimate user
    2. Normal: Slightly more difficult password than easy.
    3. Hard: the password will be hard to crack which will gave time to identify  attacker.
    4. Fun : This mode uses famous name as username
    5. Warning: this model will just warn hacker that its been detected cracking the password to scare them off.

#### Symantec Decoy Server

- Symantec have their own honeypot solution
- Decoy server is designed to be part of a suite enterprise security solution.


## Module 5

### Start of Encryption

#### The Caesar Cipher

- Shit words as a -> c
- Problem : Find most common word like "The" to decrypt it.
- Also Known: Substitution ciphers.

#### ROT13

- another single alphabet substitution cipher.
- all characters are rotated 13 characters through alphabet.
- "A CAT" => "N PNG"

#### Multi-Alphabet Substitution.

- Also called: Polyalphabetic substitution.
- eg: shits->(12,22,13)then "A CAT" => "C ADV".
- little harder to crack from Single substation.

#### Rail Fence

- Also know as: transposition cipher.
- most widely used transposition cipher is Rail fence
- Just write to alternate lines and then combine them.
- eg:"Attack at dawn" ->  A  tc a  dw
                           ta  k ta  n
   which becomes => Atcawdtaktan

#### Vigenére

- Vigenére is a polyalphabetic cipher and uses multiple substutions in order to distupt letter and word frequence.
- Mostly widely used polyalphabetic cipher
- Invented in 1553 by Giovan Battista bellaso,through it is named aafter Blaise de Vigenére.
- eg: shit of (+2,-1,+1,+3) so "Attack" =>
    A(1) +2 =3 -> C
    .
    .
    .
    k(11) - 1= 10 -> J

    =-> "CSUDEJ"

#### Enigma

- German Engineer Arthur Scherbius near the end of world war.
- Core of enigma is a rotating disk that were arranged with 26 letters in circle.
- Egnima can be thought of mechnical polyalphabetic cipher.
- to decrypt we need same rotating disk.


### Modern Encryption Method.

#### Symmetric Encryption

##### Binary Operation.

- there are 3 types of binary operation
    1. AND
    2. OR
    3. XOR

- Simpliest is XORing
    - if message is xor with some key then the result is encrypted msg
    - if result is again xored with same key we get original message.

##### Data Encryption Standard (DES)

- Deployed by IBM in eary 1970 and public at 1976.
- DES uses Symmetric key system
- DES uses short key but complex prcoess to encrypt.
    1. the data is divided into 64-bit block, this block is reorderd
    2. Reordered data is manipulated by 16 seperate round of encryption involving substitution,bit-shifting and logical operations using 56-bit key.
    3. Finally the data are reordered one last time.

- DES uses 56-bit cypher key applied to a 64-bit block.
    1. there is actually 1 byte in every block for error correction.

- problem is same as symmetric key algo how do you transmit key without it becoming compromised.
- this lead to the development of public key encryption.

##### Blowfish

- Symmetric Block cipher.
- It also uses single key for encryption and dectyption.
- message block uses variable length from 32 to 448 bits.

##### AES (Advanced Encryption Standard)

- AES uses Rijndael algorith.
- AES specifies 3 key size:128,192 and 256 bits.

#### Public Key Encryption

- It is opposite of single key encryption
- Public key to encrypt data and private key to decrypt data.

##### RSA

- Developed in 1977 by Ron Rivest,Adi Shamir, Len Adleman
- get p and q random primes and approx length
- let n = p*q
- Multiply Euler's totient for each of these primes.
- let m = (p-1)*(q-1)
- select e which is co prime to m
- find d then when multipled by e and modulo m would yeild 1
- d such that d*e mod m = 1
- P = Cd % n

###### Elliptic Curve(ECC)

- In 1985 by victor miller(IBM) and Neil Koblitz(University of Washington)
- the size of the elliptic curve determines the difficulty of finding the algorithm.
- There is actually ECC algorithms. There ia n ECC version of Diffie-Hellman, and ECC version od DSA and many others.
- US NSA has endorsed ECC by including schemes based on it inside Suite B's set of recommended algorithms, this allows use for protectinng information classified up to top secret with 384-bit keys.

#### Digital Signatures and Certificates.

- Digital signature is not used to ensure the confidentiality of a message but rather guarantee who sent the message

##### Digital Certificates

- X.509 is an international standard for the format and information.
    - Version
    - Certificate holder's public key
    - Serial number
    - Cerificate holder's distinguished name
    - Certificate's validity period
    - Unique name of certificate issuer
    - Digital signature of issuer
    - Signature algorithm identifier

##### PGP Certificates

- pretty  Good Certificates is not a specific encryption algorithm,but rather a system.
- It offers digital signatures,asymmetric encryption and symmetric encryption.
- Found in e-mail clients.
- PGP certificates are selg generated than by any certificate authority.

#### Windows and linux Encryption

- Microsoft Windows
    - Encryption File System (EFS) encodes files in order for them to be unreadable to anyone.
    - Bitlocker Drive Encrption provides another layer of protection by encryption the entire hard disk.
    - Bitlocker to go extends bitlocker encryption to removable media such as USB flash drives.

- Linux
    - Linux Unified Key Setup (LUKS) allows the encryption of linux partitions.

#### Enabling Bitlocker

- gpedit.msc
    - enable bitlocker
    - Right click turn On bitlocker

#### Hashing

- h= H(m)
- H(x) is one way function
- H(x) Collision Free
    - Salt is randoms bits to encrypt inputing hash
- NTLM used in windows for hashing

##### MD5

- MD5 is a 128-bit hash that is specified by RFC 1321.
- Ron Rivert in 1991
- Problem is that it has never been collision resistant

##### SHA

- Secure hash Algorithm widly used hasing algorithm.
    - SHA-1 : 160-bit hash function resembles the MD5 algorithm.
        - Designed by NSA
    - SHA-2 : 2 similar hash function with diffrent block size
        - SHA-256 and SHA-512
        - SHA-256 uses 32 bytes(256 bits) SHA-512 uses 64 bytes(512  bits)
        - SHA-3: latest version of SHA. It was adopted in Octomber 2012

#### Cracking password

- John the ripper
- Rainbow Tables
    - Ophcrack
- Brute Force


### Introduction to VPN

- VPN allows a remote user to have network access

#### VPN Protocols

- Point to point tunnelling protocol (PPTP)
- Layer 2 Tunnelling Protocol (L2TP)

##### PPTP

- PPP(point to point protocol) to have its packets encapsulated within internet protocol packets ip packets and forwarded over any IP network , including the internet itself.

- PPTP is an older protocol than L2TP or IPSec

- Experts consider PPTP to be less secure then L2TP or IPSec

- But it consumes fewer resources and is supported by almost every VPN implementation.

- It is bassically a secure extension to PPP

- PPTP was originally proposed as a standard in 1996 by the PPTP forum.

- PPTP is widely used because PPTP operates in data link layer layer 2 of the OSI model allowing different netwoking protocol to run over a PPTP tunnel

- PPTP supports 2 seperate technologies for accomplishing this:
    1. EAP (Extensible Authentication Protocol)
        - EAP was designed specifically with PPTP
        - EAP meant to supplant proprietary authentication system and includes a variety of authentication methods to be used,
        - Including password, challenge-response, and public key infrastructure certificates.
    2. Challenge Handshake Authentication Protocol (CHAP)
        - CHAP is 3 part handshaking procedure
        - connection established => server sends back challenge => client responds with calculated expected hash back
        - CHAP authenticate periodically providing a robust level of security

##### L2TP (layer 2 Tunnelling Protocol)

- L2TP is an  extension or enhancement of the point to point tunnelling protocol.

- It is often used to operate VPN over the internet

- It is new and improved version of PPTP

- It also works on data link layer.

- L2tp supports EAP and CHAP and additional MS-CHAP,PAP,SPAP,Kerberos

###### MS-CHAP

- MS-CHAP is a Microsoft specific extension to CHAP to authenticate remote windows workstation.

- The goal is to make the functionality available on the LAN to remote users while integrating the encryption and hashing algorithms used on windows network

- MS-CHAP can interpret and read if authentication fails and give the reason to the user why it failed

###### PAP (Password Authentication Protocol)

- Its most basic form of authentcation.
- user name and password to be transmitted over a network and compaired to the stored name password pair

###### SPAP (Shiva Password Authentication Protocol )

- SPAP is a proprietaery version of PAP
- It is secure than PAP because both username and password is encrypted when they are sent
- Attack are possible because SPAP always uses the same reversible encryption method to send the passwords over the wire

###### Keberos

- Developed by MIT
- keberos works by sending messages back and forth between the client and server
- The password is not send to the client and server it encrypts data using username and hashing

    + Principal : A server or client that kerberos can assign tickets to.
    + Authentication Service (AS): Service that authorizes the principal and connects them to the ticket granting server
    + Ticket Granting Service (TGS): Provides tickets
    + Key Distribution Centre (KDC): A server that provides the initial ticket and handles TGS requests. Often it runs both AS and TGS services.

    * Realm : A boundary within an organization. Each realm has its own AS and TGS

    + Remote Ticket Granting Server (RTGS) : A TGS in a remote realm.
    + Ticket Granting Ticket (TGT) : The ticket that is granted during the authentication process.
    + Ticket : Used to authenticate to the server. Contain identity of client, session key, timestamp and checksum.Encrypted with server's key.
    + Session Key : Temporary encryption key.
    + Authenticator : Proves session key was recently created. Often expires within 5 minutes.


##### (IPSec) Internet Protocol Security 
- IPSec is used to create virtual private networks.
- Ipsec is developed by IETF (Onternet Engineering Task Force)
- IPSec has 2 encryption modes
    - Transport :- It encrypted data but not header 
    - Tunnel :- It encryptes everything

##### SSL/TSL (Secure Sockets Layer/Transport Layer Security)
- all sending certis for verification of server and clients

##### VPN solutions 
- Cisco Solutions
- Openswan













