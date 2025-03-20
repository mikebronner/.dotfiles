<?php

declare(strict_types=1);

namespace App\Console\Commands;

use App\Actions\InstallGit;
use Illuminate\Console\Command;
use Illuminate\Console\View\Components\Task;

use function Laravel\Prompts\confirm;
use function Termwind\render;
use function Termwind\terminal;

class Install extends Command
{
    protected $signature = "app:install";
    protected $description = "Configure your dev environment.";

    public function handle(): void
    {
        $this->showIntro();

        if (! $this->shouldContinue()) {
            render(view("exit")->render());

            exit;
        }

        $this->askQuestions();
        $this->installStep('Installing Git', function (): void {
            InstallGit::run();
        });
    }

    protected function askQuestions(): void
    {

    }

    protected function installStep(string $message, callable $callback): void
    {
        (new Task($this->output))->render($message, $callback);
    }

    protected function shouldContinue(): bool
    {
        return confirm(
            default: false,
            label: "Would you like to continue?",
            no: "Not right now.",
            yes: "Yes",
        );
    }

    protected function showIntro(): void
    {
        terminal()->clear();
        render(view("welcome")->render());
    }
}
