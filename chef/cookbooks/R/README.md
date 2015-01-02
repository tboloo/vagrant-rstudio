R Cookbook
=========================
R is ‘GNU S’, a freely available language and environment for statistical computing and graphics which provides a wide variety of statistical and graphical techniques: linear and nonlinear modelling, statistical tests, time series analysis, classification, clustering, etc. Please consult the R project homepage for further information.

RStudio Server enables you to provide a browser based interface (the RStudio IDE) to a version of R running on a remote Linux server. Deploying R and RStudio on a server has a number of benefits, including:

- The ability to access your R workspace from any computer in any location;
- Easy sharing of code, data, and other files with colleagues;
- Allowing multiple users to share access to the more powerful compute resources (memory, processors, etc.) available on a well equipped server; and
- Centralized installation and configuration of R, R packages, TeX, and other supporting libraries.

RStudio Server works with recent versions of popular Linux distributions including Debian, Ubuntu, and RedHat/CentOS. RStudio Server can also be built and installed from source on other platforms (see notes on this below).

Requirements
------------
RStudio server depends an apt cookbook, and for now supports only debian machines.
All required dependencies are included in the cookbook.
Unfortunately RStudio has hard-coded dependency on buggy openssl :(

Attributes
----------
#### chef/cookbooks/R::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['rserver']['www-port']</tt></td>
    <td>String</td>
    <td>Port on which RStudio accepts connections.</td>
    <td><tt>8080</tt></td>
  </tr>
  <tr>
    <td><tt>['rserver']['www-address']</tt></td>
    <td>String</td>
    <td>Interface to bind to</td>
    <td><tt>0.0.0.0</tt></td>
  </tr>
  <tr>
    <td><tt>['rserver']['username']</tt></td>
    <td>String</td>
    <td>username for RStudio</td>
    <td><tt>ruser</tt></td>
  </tr>
  <tr>
  <td><tt>['rserver']['password']</tt></td>
    <td>String</td>
    <td>password for ['rserver']['user'], hashed with openssl passwd -1 "ruser"</td>
    <td><tt>$1$ZnGaA5f3$qcM2y5elSNSFomvXziI8/1</tt></td>
  </tr>
</table>

Usage
-----
#### chef/cookbooks/R::default

Just include `chef/cookbooks/R` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
  "recipe[R]"
  ]
}
```
Once process finishes your RStudio server is available on localhost:8888, the credentails to login are user: ruser, password: ruser

Contributing
------------
I gladly welcome updates and features (especially in terms of supporting different plantform, including SUSE, RedHat and Ubutu). If you want to contribute follow the usual steps:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Bolek Tekielski, tboloo.
