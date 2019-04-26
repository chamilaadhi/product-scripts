# product-scripts

1. delete all ``id.*`` files if any (if running on a fresh environment)
2. run ``sh create-apis.sh`` to generate two apis (api payload can be found in ``math.json`` and ``calculator.json`` file). API ids for these two apis are stored in ``id.calc_api_id`` and ``id.math_api_id`` for later use
3. run ``sh create-product.sh`` to create the product using two apis. payload for the API product (resources) can be found inside the create-product.sh script. product id is stored in ``id.productid``
4. run ``sh subscribe.sh`` to create an application and subscribe to the product. subscription id is stored in ``id.subscriptionId``

If you need to generate Access token to access rest apis, it can be done using ``sh access-token.sh`` command. (no need to run this if you are using any provided scripts)
