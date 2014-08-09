Pizaid Controller
====

Pizaid control server gathering each request from web UI and LCD panel

Requirements
----
* Ruby > 2.0
* Bundler
* Rake

Quick Start
----
1. Clone this repository
   ```
   git clone https://github.com/Pizaid/pizaid-controller.git
   cd pizaid-controller
   ```   
2. Install gems
   ```
   $ bundler install --path vender/bundler
   ```
3. Install controller
   ```
   $ rake install
   ```
4. Run server
   ```
   $ bundle exec example/simpleserver.rb
   ```

Execute a test client
----

__Requirements__
* Python 2.7

__Execute__
1. Install pip
   ```
   $ sudo aptitude install python-pip
   ```
2. Install thrift library
   ```
   $ sudo pip install thrift
   ```
3. Run test client
   ```
   $ python example/client/sampleclient.py
   ```


LICENSE
---
MIT License
