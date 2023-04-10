# quarkus-reactive-stress-test

## Run the tests
- Build the application:
  ```bash
  ./mvnw clean package
  ```
- Start the database service:
  ```bash
  docker compose --file local-deployment/docker-compose.yml up -d
  ```
- Create Database schema:
  ```bash
  ./mvnw flyway:migrate
  ```
- Start the application:
  ```bash
  java -jar target/quarkus-app/quarkus-run.jar
  ```
- Start JMeter tests:
  
  In a different terminal, run:
  ```
  ./mvnw jmeter:jmeter
  ```
  Test execution takes a moment (1-2 minutes).

## Results
During test execution, we are able to observe `Exception`s in the application log:
```bash
...
2023-04-10 09:44:14,811 ERROR [org.jbo.res.rea.com.cor.AbstractResteasyReactiveContext] (vert.x-eventloop-thread-0) Request failed: javax.persistence.PersistenceException: org.hibernate.HibernateException: java.util.concurrent.CompletionException: java.lang.IllegalStateException: HR000069: Detected use of the reactive Session from a different Thread than the one which was used to open the reactive Session - this suggests an invalid integration; original thread [21]: 'vert.x-eventloop-thread-0' current Thread [28]: 'vert.x-eventloop-thread-7'
	at org.hibernate.internal.ExceptionConverterImpl.convert(ExceptionConverterImpl.java:154)
	at org.hibernate.internal.ExceptionConverterImpl.convert(ExceptionConverterImpl.java:181)
	at org.hibernate.reactive.session.impl.ReactiveExceptionConverter.convert(ReactiveExceptionConverter.java:31)
	at org.hibernate.reactive.session.impl.ReactiveSessionImpl.lambda$firePersist$19(ReactiveSessionImpl.java:708)
	at java.base/java.util.concurrent.CompletableFuture.uniHandle(CompletableFuture.java:934)
	at java.base/java.util.concurrent.CompletableFuture$UniHandle.tryFire(CompletableFuture.java:911)
	at java.base/java.util.concurrent.CompletableFuture.postComplete(CompletableFuture.java:510)
	at java.base/java.util.concurrent.CompletableFuture.complete(CompletableFuture.java:2147)
	at java.base/java.util.concurrent.CompletableFuture.uniAcceptNow(CompletableFuture.java:757)
	at java.base/java.util.concurrent.CompletableFuture.uniAcceptStage(CompletableFuture.java:735)
	at java.base/java.util.concurrent.CompletableFuture.thenAccept(CompletableFuture.java:2182)
	at java.base/java.util.concurrent.CompletableFuture.thenAccept(CompletableFuture.java:144)
	at org.hibernate.reactive.id.impl.BlockingIdentifierGenerator.lambda$generate$1(BlockingIdentifierGenerator.java:94)
	at java.base/java.util.ArrayList.forEach(ArrayList.java:1511)
	at org.hibernate.reactive.id.impl.BlockingIdentifierGenerator.lambda$generate$0(BlockingIdentifierGenerator.java:87)
	at java.base/java.util.concurrent.CompletableFuture$UniAccept.tryFire(CompletableFuture.java:718)
	at java.base/java.util.concurrent.CompletableFuture.postComplete(CompletableFuture.java:510)
	at java.base/java.util.concurrent.CompletableFuture.complete(CompletableFuture.java:2147)
	at io.vertx.core.Future.lambda$toCompletionStage$3(Future.java:384)
	at io.vertx.core.impl.future.FutureImpl$3.onSuccess(FutureImpl.java:141)
	at io.vertx.core.impl.future.FutureBase.emitSuccess(FutureBase.java:60)
	at io.vertx.core.impl.future.FutureImpl.tryComplete(FutureImpl.java:211)
	at io.vertx.core.impl.future.PromiseImpl.tryComplete(PromiseImpl.java:23)
	at io.vertx.sqlclient.impl.QueryResultBuilder.tryComplete(QueryResultBuilder.java:100)
	at io.vertx.sqlclient.impl.QueryResultBuilder.tryComplete(QueryResultBuilder.java:34)
	at io.vertx.core.Promise.complete(Promise.java:66)
	at io.vertx.core.Promise.handle(Promise.java:51)
	at io.vertx.core.Promise.handle(Promise.java:29)
	at io.vertx.core.impl.future.FutureImpl$3.onSuccess(FutureImpl.java:141)
	at io.vertx.core.impl.future.FutureBase.emitSuccess(FutureBase.java:60)
	at io.vertx.core.impl.future.FutureImpl.tryComplete(FutureImpl.java:211)
	at io.vertx.core.impl.future.PromiseImpl.tryComplete(PromiseImpl.java:23)
	at io.vertx.core.impl.future.PromiseImpl.onSuccess(PromiseImpl.java:49)
	at io.vertx.core.impl.future.PromiseImpl.handle(PromiseImpl.java:41)
	at io.vertx.sqlclient.impl.TransactionImpl.lambda$wrap$0(TransactionImpl.java:72)
	at io.vertx.core.impl.future.FutureImpl$3.onSuccess(FutureImpl.java:141)
	at io.vertx.core.impl.future.FutureBase.lambda$emitSuccess$0(FutureBase.java:54)
	at io.vertx.core.impl.EventLoopContext.execute(EventLoopContext.java:86)
	at io.vertx.core.impl.DuplicatedContext.execute(DuplicatedContext.java:163)
	at io.vertx.core.impl.future.FutureBase.emitSuccess(FutureBase.java:51)
	at io.vertx.core.impl.future.FutureImpl.tryComplete(FutureImpl.java:211)
	at io.vertx.core.impl.future.PromiseImpl.tryComplete(PromiseImpl.java:23)
	at io.vertx.core.impl.future.PromiseImpl.onSuccess(PromiseImpl.java:49)
	at io.vertx.core.impl.future.PromiseImpl.handle(PromiseImpl.java:41)
	at io.vertx.core.impl.future.PromiseImpl.handle(PromiseImpl.java:23)
	at io.vertx.sqlclient.impl.command.CommandResponse.fire(CommandResponse.java:46)
	at io.vertx.sqlclient.impl.SocketConnectionBase.handleMessage(SocketConnectionBase.java:292)
	at io.vertx.pgclient.impl.PgSocketConnection.handleMessage(PgSocketConnection.java:97)
	at io.vertx.sqlclient.impl.SocketConnectionBase.lambda$init$0(SocketConnectionBase.java:105)
	at io.vertx.core.impl.EventLoopContext.emit(EventLoopContext.java:55)
	at io.vertx.core.impl.ContextBase.emit(ContextBase.java:239)
	at io.vertx.core.net.impl.NetSocketImpl.handleMessage(NetSocketImpl.java:390)
	at io.vertx.core.net.impl.ConnectionBase.read(ConnectionBase.java:157)
	at io.vertx.core.net.impl.VertxHandler.channelRead(VertxHandler.java:153)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:442)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:420)
	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:412)
	at io.netty.channel.CombinedChannelDuplexHandler$DelegatingChannelHandlerContext.fireChannelRead(CombinedChannelDuplexHandler.java:436)
	at io.vertx.pgclient.impl.codec.PgEncoder.lambda$write$0(PgEncoder.java:98)
	at io.vertx.pgclient.impl.codec.PgCommandCodec.handleReadyForQuery(PgCommandCodec.java:139)
	at io.vertx.pgclient.impl.codec.PgDecoder.decodeReadyForQuery(PgDecoder.java:237)
	at io.vertx.pgclient.impl.codec.PgDecoder.channelRead(PgDecoder.java:96)
	at io.netty.channel.CombinedChannelDuplexHandler.channelRead(CombinedChannelDuplexHandler.java:251)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:442)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:420)
	at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:412)
	at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1410)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:440)
	at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:420)
	at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:919)
	at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:166)
	at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:788)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:724)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:650)
	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:562)
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:997)
	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
	at java.base/java.lang.Thread.run(Thread.java:833)
Caused by: org.hibernate.HibernateException: java.util.concurrent.CompletionException: java.lang.IllegalStateException: HR000069: Detected use of the reactive Session from a different Thread than the one which was used to open the reactive Session - this suggests an invalid integration; original thread [21]: 'vert.x-eventloop-thread-0' current Thread [28]: 'vert.x-eventloop-thread-7'
	... 77 more
Caused by: java.util.concurrent.CompletionException: java.lang.IllegalStateException: HR000069: Detected use of the reactive Session from a different Thread than the one which was used to open the reactive Session - this suggests an invalid integration; original thread [21]: 'vert.x-eventloop-thread-0' current Thread [28]: 'vert.x-eventloop-thread-7'
	at java.base/java.util.concurrent.CompletableFuture.encodeThrowable(CompletableFuture.java:315)
	at java.base/java.util.concurrent.CompletableFuture.uniComposeStage(CompletableFuture.java:1194)
	at java.base/java.util.concurrent.CompletableFuture.thenCompose(CompletableFuture.java:2309)
	at java.base/java.util.concurrent.CompletableFuture.thenCompose(CompletableFuture.java:144)
	at org.hibernate.reactive.event.impl.AbstractReactiveSaveEventListener.reactivePerformSaveOrReplicate(AbstractReactiveSaveEventListener.java:252)
	at org.hibernate.reactive.event.impl.AbstractReactiveSaveEventListener.lambda$reactivePerformSave$2(AbstractReactiveSaveEventListener.java:175)
	at java.base/java.util.concurrent.CompletableFuture.uniComposeStage(CompletableFuture.java:1187)
	at java.base/java.util.concurrent.CompletableFuture.thenCompose(CompletableFuture.java:2309)
	at java.base/java.util.concurrent.CompletableFuture.thenCompose(CompletableFuture.java:144)
	at org.hibernate.reactive.event.impl.AbstractReactiveSaveEventListener.reactivePerformSave(AbstractReactiveSaveEventListener.java:175)
	at org.hibernate.reactive.event.impl.AbstractReactiveSaveEventListener.lambda$reactiveSaveWithGeneratedId$0(AbstractReactiveSaveEventListener.java:125)
	at java.base/java.util.concurrent.CompletableFuture$UniCompose.tryFire(CompletableFuture.java:1150)
	... 73 more
Caused by: java.lang.IllegalStateException: HR000069: Detected use of the reactive Session from a different Thread than the one which was used to open the reactive Session - this suggests an invalid integration; original thread [21]: 'vert.x-eventloop-thread-0' current Thread [28]: 'vert.x-eventloop-thread-7'
	at org.hibernate.reactive.common.InternalStateAssertions.assertCurrentThreadMatches(InternalStateAssertions.java:46)
	at org.hibernate.reactive.session.impl.ReactiveSessionImpl.threadCheck(ReactiveSessionImpl.java:158)
	at org.hibernate.reactive.session.impl.ReactiveSessionImpl.getReactiveActionQueue(ReactiveSessionImpl.java:168)
	at org.hibernate.reactive.event.impl.AbstractReactiveSaveEventListener.addInsertAction(AbstractReactiveSaveEventListener.java:343)
	at org.hibernate.reactive.event.impl.AbstractReactiveSaveEventListener.lambda$reactivePerformSaveOrReplicate$4(AbstractReactiveSaveEventListener.java:279)
	at java.base/java.util.concurrent.CompletableFuture.uniComposeStage(CompletableFuture.java:1187)
	... 83 more
...
```

In the logs of the JMeter tests, we see that about 3.3% of all test calls resulted in an error:
```bash
cat target/jmeter/logs/http.jmx.log
..
2023-04-10 09:44:14,921 INFO o.a.j.r.Summariser: summary =  80000 in 00:00:56 = 1427.2/s Avg:     5 Min:     0 Max:   551 Err:  2650 (3.31%)
```