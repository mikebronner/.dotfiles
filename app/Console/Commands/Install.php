<?php

declare(strict_types=1);

namespace App\Console\Commands;

use App\Actions\InstallGit;
use Illuminate\Console\Command;
use Illuminate\Console\View\Components\Task;

class Install extends Command
{
    protected $signature = "app:install";
    protected $description = "Configure your dev environment.";

    public function handle(): void
    {
        $this->installStep('Installing Git', function (): void {
            InstallGit::run();
        });
    }

    protected function installStep(string $message, callable $callback): void
    {
        (new Task($this->output))->render($message, $callback);
    }
}
