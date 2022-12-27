# wireguard-on-gcp

## Usage
- Install terraform and make it ready to apply to GCP
- Update config
  - Key Generation
    - Ref: https://www.wireguard.com/quickstart/#key-generation
  - `vpn/wg0.conf`
    - Replace `PrivateKey` and `PublicKey`
  - `vpn/client_sample.conf`
    - Replace `PrivateKey`, `PublicKey` and `Endpoint`
- Update project id and apply
  - Update `project` value in `vpn/variables.tf`
  - Apply
    ```
    $ cd vpn 
    $ terraform init
    $ terraform plan
    $ terraform apply 
    ```
- Import configuration file(`vpn/client_sample.conf`) to your WireGuard client
  - APP download link
    - Mac: https://apps.apple.com/jp/app/wireguard/id1451685025?mt=12
    - iPhone: https://apps.apple.com/jp/app/wireguard/id1441195209
