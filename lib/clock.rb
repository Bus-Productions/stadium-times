require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'
require 'backend_jobs'

include Clockwork

every(3.minutes, 'Queuing post scores' ) { BackendJobs.new(1).score_posts.delay }
every(3.minutes, 'Queuing comment scores' ) { BackendJobs.new(1).score_comments.delay }

# every(1.minute, 'Queuing execution of portfolio daily open calculation') { PassOverPortfoliosJob.new(1).record_daily_open.delay }
# every(1.minute, 'Queuing execution of stocks daily open calculation') { PassOverStocksJob.new(1).record_daily_open.delay }

# every(3.minutes, 'Queuing execution of market open trades' ) { MarketOpenTradesJob.new(1).perform.delay }
# #every(1.minute, 'Queuing execution of portfolio daily open calculation' ) { PassOverPortfoliosJob.new(1).record_daily_open.delay }
# #every(1.minute, 'Queuing execution of portfolio daily open calculation' ) { PassOverStocksJob.new(1).record_daily_open.delay }

# every(6.minutes, 'Submitting dummy trades') { PassOverStocksJob.new(1).dummy_trades.delay }
# every(8.minutes, 'Checking on pending trades') { MarketOpenTradesJob.new(1).check_on_pending_trades.delay }
# every(4.minutes, 'Checking on stock prices') { PassOverStocksJob.new(1).check_on_all_stock_prices.delay }

# every(30.minutes, 'Queueing calculation of portfolio cash') { PassOverPortfoliosJob.new(1).calculate_cash_values.delay }

# every(4.minutes, 'Queueing calculation of portfolio values') { PassOverPortfoliosJob.new(1).perform.delay }
# every(4.minutes, 'Queueing calculation of stock values') { PassOverStocksJob.new(1).perform.delay }

# every(30.minutes, 'Queueing calculation of portfolio rank') { PassOverPortfoliosJob.new(1).rank_portfolios.delay }

# every(30.minutes, 'Queueing search for Users to Upgrade') { PassOverPortfoliosJob.new(1).upgrade_users_who_invite.delay }