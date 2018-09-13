# elixir-google-pubsub-example
Elixir application using Google Pub Sub



#### Running the application

I've created this application to test how Google PubSub works and their concepts like topics, publishers, subscribers and messages.o

To run this project just run the following commands:

1. `docker-compose up -d pubsub` to start fake pubsub
2. `docker-compose up -d publisher1 publisher2` to start publishers
3. `docker-compose up -d subscriber1 subscriber2 subscriber3` to start subscribers

You can see the logs running `docker-compose logs -f ${service_name_1} [...#{service_name_n}]`
`${service_name}` should be `publisher1`, `publisher2`, `subscriber1`, `subscriber2`, `subscriber3` or `pubsub`



#### Publishers

The publisher send messages to the same topic called `my-awesome-topic`.
One of them send messages with a interval of 1 second and the other use 3 seconds.



#### Subscribers

Two of three subscribers (`subscriber1` and `subscriber2`) uses the same subscription (`my-awesome-subscription1`).
The other, `subscriber3` uses subscription called `my-awesome-subscription2`.
